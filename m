From: David Miller <davem@davemloft.net>
Date: Mon, 07 Dec 2015 16:28:02 -0500 (EST)
Subject: [Intel-wired-lan] [PATCH v9] i40e: Look up MAC address in Open
	Firmware or IDPROM
In-Reply-To: <20151207200634.GA4415@oracle.com>
References: <20151207200634.GA4415@oracle.com>
Message-ID: <20151207.162802.462148155042537146.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 7 Dec 2015 15:06:34 -0500

> This is the i40e equivalent of commit c762dff24c06 ("ixgbe: Look up MAC
> address in Open Firmware or IDPROM").
> 
> As with that fix, attempt to look up the MAC address in Open Firmware
> on systems that support it, and use IDPROM on SPARC if no OF address
> is found.
> 
> In the case of the i40e there is an assumption that the default mac
> address has already been set up as the primary mac filter on probe,
> so if this filter is obtained from the Open Firmware or IDPROM, an
> explicit write is needed via i40e_aq_mac_address_write() and
> i40e_aq_add_macvlan() invocation.
> 
> The I40E_FLAG_PF_MAC flag in the platform-private i40e_pf structure
> tracks whether a platform-specific mac address was found, in which
> case calls to i40e_aq_mac_address_write() and i40e_aq_add_macvlan()
> will be triggered.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

This looks good to me.

Once this goes in I'll add my generic MAC stuff to net-next and then
we can convert the various Intel drivers to use it.
