From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 5 Feb 2021 23:28:49 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix NULL ptr dereference
 on VSI filter sync
In-Reply-To: <1612439746-27796-1-git-send-email-michal.maloszewski@intel.com>
References: <1612439746-27796-1-git-send-email-michal.maloszewski@intel.com>
Message-ID: <1138c5f3d7eb757638b321d23e28ea79708005a1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-02-04 at 11:55 +0000, Micha? Ma?oszewski wrote:
> Remove the reason of null pointer dereference in sync vsi filters.
> Added new I40E_VSI_RELEASING flag to signalize deleting and releasing
> of VSI resources to sync this thread with sync filters subtask.
> Without this patch it is possible to start update the vsi filter list
> after vsi is removed, that's causing a kernel oops.
> 
> Fixes: 17652c6336fd("i40e: remove unused argument")
> Reviewed-on: https://git-amr-1.devtools.intel.com/gerrit/282326

The Reviewed-on should not be included.

> Reviewed-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> Reviewed-by: Fijalkowski, WitoldX <witoldx.fijalkowski@intel.com>
> Reviewed-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 drivers/net/ethernet/intel/i40e/i40e.h
>  mode change 100644 => 100755
> drivers/net/ethernet/intel/i40e/i40e_main.c

I believe this was unintended?

ERROR: do not set execute permissions for source files
#26: FILE: drivers/net/ethernet/intel/i40e/i40e.h

ERROR: do not set execute permissions for source files
#40: FILE: drivers/net/ethernet/intel/i40e/i40e_main.c

