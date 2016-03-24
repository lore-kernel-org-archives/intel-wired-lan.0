From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 24 Mar 2016 02:20:24 +0000
Subject: [Intel-wired-lan] [next PATCH 2/2] igb: Fix sparse warning
 about passing __beXX into leXX_to_cpup
In-Reply-To: <20160318230653.14801.86163.stgit@localhost.localdomain>
References: <20160318230425.14801.87895.stgit@localhost.localdomain>
 <20160318230653.14801.86163.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EB3C9D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, March 18, 2016 4:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 2/2] igb: Fix sparse warning about
> passing __beXX into leXX_to_cpup
> 
> We were casting the addr as __beXX and then passing it into le32_to_cpu
> because the device expects the MAC address to be in network order even
> though the register set is little endian.  Instead of casting it as __beXX
> we can just cast it as __leXX in order to maintain consistency since the
> region of memory is already in little endian order as far as we are
> concerned.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
