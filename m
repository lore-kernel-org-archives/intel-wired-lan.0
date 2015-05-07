From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 07 May 2015 04:49:48 -0700
Subject: [Intel-wired-lan] [PATCH v1 net-next 1/2] igb: add PHY support
	for Broadcom 5461S
In-Reply-To: <1429302240-654-1-git-send-email-jtoppins@cumulusnetworks.com>
References: <1429302240-654-1-git-send-email-jtoppins@cumulusnetworks.com>
Message-ID: <1430999388.32618.21.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-17 at 13:23 -0700, Jonathan Toppins wrote:
> From: Alan Liebthal <alanl@cumulusnetworks.com>
> 
> The Quanta LY8 Ethernet management port uses a Broadcom 5461S chip for
> the PHY layer. This adds support for this PHY to the Intel igb driver.
> 
> Signed-off-by: Alan Liebthal <alanl@cumulusnetworks.com>
> Signed-off-by: Jonathan Toppins <jtoppins@cumulusnetworks.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c   |   20 +++++-
>  drivers/net/ethernet/intel/igb/e1000_defines.h |    1 +
>  drivers/net/ethernet/intel/igb/e1000_hw.h      |    1 +
>  drivers/net/ethernet/intel/igb/e1000_phy.c     |   79
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igb/e1000_phy.h     |    2 +
>  5 files changed, 102 insertions(+), 1 deletion(-)

After at lot of discussion on these changes, we would like to you to use
the PHYLib approach.  I know that means adding PHYLib support to our
drivers, which we currently do not have.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150507/16fbf014/attachment.asc>
