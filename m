From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 9 Mar 2016 23:51:47 +0000
Subject: [Intel-wired-lan] [net PATCH 2/2] e1000: Double Tx
	descriptors	needed check for 82544
In-Reply-To: <20160302211608.2124.80148.stgit@localhost.localdomain>
References: <20160302205129.2124.67042.stgit@localhost.localdomain>
 <20160302211608.2124.80148.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EABCE4@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, March 2, 2016 1:16 PM
> To: netdev at vger.kernel.org; jogreene at redhat.com; intel-wired-
> lan at lists.osuosl.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> sassmann at redhat.com
> Subject: [Intel-wired-lan] [net PATCH 2/2] e1000: Double Tx descriptors
> needed check for 82544
> 
> The 82544 has code that adds one additional descriptor per data buffer.
> However we weren't taking that into acount when determining the
> descriptors
> needed for the next transmit at the end of the xmit_frame path.
> 
> This change takes that into account by doubling the number of descriptors
> needed for the 82544 so that we can avoid a potential issue where we could
> hang the Tx ring by loading frames with xmit_more enabled and then
> stopping
> the ring without writing the tail.
> 
> In addition it adds a few more descriptors to account for some additional
> workarounds that have been added over time.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c |   19
> ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
