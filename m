From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 27 Jul 2016 14:38:07 -0700
Subject: [Intel-wired-lan] [e1000_netpoll] BUG: sleeping function called
 from invalid context at kernel/irq/manage.c:110
In-Reply-To: <1469524492.17736.3.camel@edumazet-glaptop3.roam.corp.google.com>
References: <20160726035003.GA15095@wfg-t540p.sh.intel.com>
 <1469524492.17736.3.camel@edumazet-glaptop3.roam.corp.google.com>
Message-ID: <1469655487.2232.49.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-07-26 at 11:14 +0200, Eric Dumazet wrote:
> Could you try this ?
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c
> b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index
> f42129d09e2c23ba9fdb5cde890d50ecb7166a42..a53c41c4c4f7d1fe52f95a2cab8784a
> 938b3820b 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -5257,9 +5257,13 @@ static void e1000_netpoll(struct net_device
> *netdev)
> ?{
> ????????struct e1000_adapter *adapter = netdev_priv(netdev);
> ?
> -???????disable_irq(adapter->pdev->irq);
> -???????e1000_intr(adapter->pdev->irq, netdev);
> -???????enable_irq(adapter->pdev->irq);
> +???????if (napi_schedule_prep(&adapter->napi)) {
> +???????????????adapter->total_tx_bytes = 0;
> +???????????????adapter->total_tx_packets = 0;
> +???????????????adapter->total_rx_bytes = 0;
> +???????????????adapter->total_rx_packets = 0;
> +???????????????__napi_schedule(&adapter->napi);
> +???????}
> ?}
> ?#endif
> ?

Since this fixes the issue?Fengguang saw, will you be submitting a formal
patch Eric? (please) I can get this queued up for Dave's net tree as soon
as I receive the formal patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160727/292e5060/attachment.asc>
