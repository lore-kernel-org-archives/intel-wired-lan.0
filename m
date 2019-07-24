From: Chuhong Yuan <hslester96@gmail.com>
Date: Wed, 24 Jul 2019 16:13:03 +0800
Subject: [Intel-wired-lan] [PATCH net-next v2 0/8] Use dev_get_drvdata
 where possible
In-Reply-To: <20190724060512.23899-1-hslester96@gmail.com>
References: <20190724060512.23899-1-hslester96@gmail.com>
Message-ID: <CANhBUQ0gYF+cF1EjfSA-WVvAKipQHWgkasXN91mphHYsZV+uMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jul 24, 2019 at 2:05 PM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> These patches use dev_get_drvdata instead of
> using to_pci_dev + pci_get_drvdata to make
> code simpler where possible.
>
> Changelog:
>
> v1 -> v2:
> - Change pci_set_drvdata to dev_set_drvdata
>   to keep consistency.
>

Hi all,
I checked the cases which mentioned the consistency
of get/set_drvdata usages.
The cases' commit IDs are
488d040e3a3452a0dceef5d3ec4f61942262f57f
b77c98780e682fe780d899b91543769d4cf94585

After checking, I think that the consistency problem
refers to inconsistency between probe and remove.
But the changes of these patches are not related
to probe and remove.

So I think the previously sent and applied v1 patches
which do not change pci_set_drvdata to dev_set_drvdata
are okay.
Therefore there may be no need to use these v2 patches.

Regards,
Chuhong


> Chuhong Yuan (8):
>   net: 3com: 3c59x: Use dev_get_drvdata
>   net: atheros: Use dev_get_drvdata
>   net: broadcom: Use dev_get_drvdata
>   e1000e: Use dev_get_drvdata where possible
>   fm10k: Use dev_get_drvdata
>   i40e: Use dev_get_drvdata
>   igb: Use dev_get_drvdata where possible
>   net: jme: Use dev_get_drvdata
>
>  drivers/net/ethernet/3com/3c59x.c               |  8 +++-----
>  drivers/net/ethernet/atheros/alx/main.c         |  8 +++-----
>  drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 10 ++++------
>  drivers/net/ethernet/atheros/atlx/atl1.c        |  8 +++-----
>  drivers/net/ethernet/broadcom/bnx2.c            |  8 +++-----
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c       |  8 +++-----
>  drivers/net/ethernet/broadcom/tg3.c             |  8 +++-----
>  drivers/net/ethernet/intel/e1000e/netdev.c      |  9 ++++-----
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |  6 +++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 10 ++++------
>  drivers/net/ethernet/intel/igb/igb_main.c       |  5 ++---
>  drivers/net/ethernet/jme.c                      |  8 +++-----
>  12 files changed, 38 insertions(+), 58 deletions(-)
>
> --
> 2.20.1
>
