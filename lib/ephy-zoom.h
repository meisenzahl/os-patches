/* -*- Mode: C; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- */
/*
 *  Copyright © 2003 Christian Persch
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

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <glib.h>
#include <glib/gi18n.h>

G_BEGIN_DECLS

static const
struct
{
  const gchar *name;
  float level;
}
zoom_levels[] =
{
  { N_("50%"), 0.7071067811 },
  { N_("75%"), 0.8408964152 },
  { N_("100%"), 1.0 },
  { N_("125%"), 1.1892071149 },
  { N_("150%"), 1.4142135623 },
  { N_("175%"), 1.6817928304 },
  { N_("200%"), 2.0 },
  { N_("300%"), 2.8284271247 },
  { N_("400%"), 4.0 }
};

static const guint n_zoom_levels = G_N_ELEMENTS (zoom_levels);

#define ZOOM_MINIMAL  (zoom_levels[0].level)
#define ZOOM_MAXIMAL  (zoom_levels[n_zoom_levels - 1].level)
#define ZOOM_IN   (-1.0)
#define ZOOM_OUT  (-2.0)

int         ephy_zoom_get_zoom_level_index   (float level);
float       ephy_zoom_get_changed_zoom_level (float level,
                                              int   steps);
float       ephy_zoom_get_nearest_zoom_level (float level);
const char *ephy_zoom_get_zoom_level_name    (float level);

G_END_DECLS
