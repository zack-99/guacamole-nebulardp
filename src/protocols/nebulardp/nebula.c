/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

#include "rdp.h"
#include "nebula.h"

#include <guacamole/mem.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

/**
 * Starts the nebula session.
 */
int start_nebula_session(guac_rdp_client* client) {
    nebula_data* nebula_data = guac_mem_alloc(sizeof(nebula_data));

    nebula_data->nebula_pid = fork();

    if (nebula_data->nebula_pid == 0) {
        // This is the child process. Execute nebula.
        execlp("nebula",
               "nebula",
               "-config",
               "/etc/nebula/config.guacd.yml", (char *)NULL);
    } else if (nebula_data->nebula_pid < 0)
        // Fork failed
        return 1;



    // Wait for nebula to start

    pid_t ping_pid = fork();

    if (ping_pid == 0) {
        // This is the child process. Execute 5 ping to do the punch hole.
        execl("/bin/sh", "sh", "-c", "ping", "-c", "5", client->settings->hostname, (char *) NULL);
    } else if (ping_pid < 0)
        // Fork failed
        return 1;

    waitpid(ping_pid, NULL, WUNTRACED | WCONTINUED);



    client->nebula_data = nebula_data;

    return 0;
}

/**
 * Closes the nebula session.
 */
int stop_nebula_session(guac_rdp_client* client) {
    return 0;
}

