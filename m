From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 23 Sep 2016 19:51:42 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 2/2] i40e: fix setting
 debug parameter early
In-Reply-To: <1474637458-5255-3-git-send-email-sassmann@kpanic.de>
References: <1474637458-5255-1-git-send-email-sassmann@kpanic.de>
 <1474637458-5255-3-git-send-email-sassmann@kpanic.de>
Message-ID: <CAKgT0UfmZo0a7eQNw9BLk5qcgDsVK5j5G+_Ab7Zo7Mvcys=KDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 23, 2016 at 6:30 AM, Stefan Assmann <sassmann@kpanic.de> wrote:
> pf->msg_enable is a bitmask, therefore assigning the value of the
> "debug" parameter is wrong. It is initialized again later in
> i40e_sw_init() so it didn't cause any problem, except that we missed
> early debug messages. Moved the initialization and assigned
> pf->hw.debug_mask the bitmask as that's what the driver actually uses
> in i40e_debug(). Otherwise the debug parameter is just a noop.
>
> Fixes: 5b5faa4 ("i40e: enable debug earlier")
>
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 56369761..f972f0d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -8498,11 +8498,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
>         int err = 0;
>         int size;
>
> -       pf->msg_enable = netif_msg_init(debug,
> -                                       NETIF_MSG_DRV    |
> -                                       NETIF_MSG_PROBE  |
> -                                       NETIF_MSG_LINK);
> -
>         /* Set default capability flags */
>         pf->flags = I40E_FLAG_RX_CSUM_ENABLED |
>                     I40E_FLAG_MSI_ENABLED     |
> @@ -10812,10 +10807,13 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>         mutex_init(&hw->aq.asq_mutex);
>         mutex_init(&hw->aq.arq_mutex);
>
> -       if (debug != -1) {
> -               pf->msg_enable = pf->hw.debug_mask;
> -               pf->msg_enable = debug;
> -       }
> +       /* enable debug prints if requested */
> +       pf->msg_enable = netif_msg_init(debug,
> +                                       NETIF_MSG_DRV   |
> +                                       NETIF_MSG_PROBE |
> +                                       NETIF_MSG_LINK);
> +       if (debug != -1)
> +               pf->hw.debug_mask = pf->msg_enable;
>
>         /* do a special CORER for clearing PXE mode once at init */
>         if (hw->revision_id == 0 &&

The patch is broken, mainly because the code was already broken.  The
flags in pf->hw.debug_mask are in no way related to pf->msg_enable.
For now just use the default mask provided to populate
pf->hw.debug_mask and then the msg_enable portion is fine.

- Alex
