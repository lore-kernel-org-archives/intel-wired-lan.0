From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 9 Mar 2016 23:50:20 +0000
Subject: [Intel-wired-lan] [net PATCH 1/2] e1000: Do not overestimate
 descriptor counts in Tx pre-check
In-Reply-To: <20160302211601.2124.64160.stgit@localhost.localdomain>
References: <20160302205129.2124.67042.stgit@localhost.localdomain>
 <20160302211601.2124.64160.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EABCD0@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Alexander Duyck
> Sent: Wednesday, March 2, 2016 1:16 PM
> To: netdev at vger.kernel.org; jogreene at redhat.com; intel-wired-
> lan at lists.osuosl.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> sassmann at redhat.com
> Subject: [net PATCH 1/2] e1000: Do not overestimate descriptor counts in Tx
> pre-check
> 
> The current code path is capable of grossly overestimating the number of
> descriptors needed to transmit a new frame.  This specifically occurs if
> the skb contains a number of 4K pages.  The issue is that the logic for
> determining the descriptors needed is ((S) >> (X)) + 1.  When X is 12 it
> means that we were indicating that we required 2 descriptors for each 4K
> page when we only needed one.
> 
> This change corrects this by instead adding (1 << (X)) - 1 to the S value
> instead of adding 1 after the fact.  This way we get an accurate descriptor
> needed count as we are essentially doing a DIV_ROUNDUP().
> 
> Reported-by: Ivan Suzdal <isuzdal@mirantis.com>
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
