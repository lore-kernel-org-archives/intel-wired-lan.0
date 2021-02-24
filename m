From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 24 Feb 2021 23:30:23 +0000
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix NULL ptr dereference
 on VSI filter sync
In-Reply-To: <1614168468-16223-1-git-send-email-michal.maloszewski@intel.com>
References: <1614168468-16223-1-git-send-email-michal.maloszewski@intel.com>
Message-ID: <7b8565743f5b7b651b402db9617bd96cad8013a9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-02-24 at 12:07 +0000, Micha? Ma?oszewski wrote:
> Remove the reason of null pointer dereference in sync vsi filters.
> Added new I40E_VSI_RELEASING flag to signalize deleting and releasing
> of VSI resources to sync this thread with sync filters subtask.
> Without this patch it is possible to start update the vsi filter list
> after vsi is removed, that's causing a kernel oops.
> 
> Fixes: 17652c6336fd("i40e: remove unused argument")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off by: Michal Maloszewski <michal.maloszewski@intel.com>

I went ahead and fixed this, but your sign off is missing a '-'

> Reviewed-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> Reviewed-by: Fijalkowski, WitoldX <witoldx.fijalkowski@intel.com>
> Reviewed-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v3: removed features of other patches and changed permissions to 664

Please keep the full revision history, not just the most recent.

Thanks,
Tony
