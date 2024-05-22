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

#ifndef GUAC_NEBULA_H
#define GUAC_NEBULA_H

#include <guacamole/user.h>

#include <sys/types.h>

/**
 * The nebula data used for the session.
 */
typedef struct nebula_data {
    
    /**
     * The nebula files (certificate and key) used for the session.
     */
    int session_id;

} nebula_data;

/**
 * Starts the nebula session.
 */
int start_nebula_session(nebula_data* nebula, guac_user* user, char* hostname, char* protocol);

/**
 * Closes the nebula session.
 */
int stop_nebula_session(nebula_data* nebula, guac_user* user, char* hostname);

#endif
