From: David Miller <davem@davemloft.net>
Date: Thu, 05 Nov 2015 10:31:26 -0500 (EST)
Subject: [Intel-wired-lan] [PATCH v6] i40e: Look up MAC address in Open
	Firmware or IDPROM
In-Reply-To: <20151104232100.GJ14575@oracle.com>
References: <20151104232100.GJ14575@oracle.com>
Message-ID: <20151105.103126.148818796422971143.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 4 Nov 2015 18:21:00 -0500

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
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

Thanks for doing this.

Longer term we really need an abstract interface by which
architectures can provide a "system" or "firmware" MAC address
which applies to a given 'dev'.

Because these SPARC ifdef'y things really should propagate to
driver after driver after driver.

I'll see if I can cook something up.
