/* -*- Mode: C; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- */
/*
 *  Copyright © 2014 Igalia S.L.
 *
 *  This file is part of Epiphany.
 *
 *  Epiphany is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Epiphany is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Epiphany.  If not, see <http://www.gnu.org/licenses/>.
 */

#pragma once

#include <glib-object.h>
#include <webkit2/webkit-web-extension.h>

G_BEGIN_DECLS

#define EPHY_TYPE_WEB_EXTENSION (ephy_web_extension_get_type())

G_DECLARE_FINAL_TYPE (EphyWebExtension, ephy_web_extension, EPHY, WEB_EXTENSION, GObject)

EphyWebExtension *ephy_web_extension_get            (void);
void              ephy_web_extension_initialize     (EphyWebExtension   *extension,
                                                     WebKitWebExtension *wk_extension,
                                                     const char         *server_address,
                                                     const char         *adblock_data_dir,
                                                     gboolean            is_private_profile,
                                                     gboolean            is_browser_mode);

G_END_DECLS
