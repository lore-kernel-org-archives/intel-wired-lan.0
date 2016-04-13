From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Apr 2016 17:57:17 +0000
Subject: [Intel-wired-lan] [next PATCH S33 06/13] i40e: Allow user to
 change	input set mask for flow director
In-Reply-To: <1460475052-6348-7-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460475052-6348-7-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D0750@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Tuesday, April 12, 2016 8:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S33 06/13] i40e: Allow user to change
> input set mask for flow director
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> This patch implements feature, which allows user to change input set mask
> for flow director using side-band channel.
> This patch adds definition of FLOW_TYPE_MASK into the header file.
> With this patch, user can now specify less than 4 tuple(src ip, dsp ip, src port,
> dst port) for flow type tcp4/udp4.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-Id: I90052508f8c172c0da5a4b78b949704b4a59ea78
> ---
> Testing Hints :
> e.g. Using ethtoool, side-band filters are programmed such as:
> 	ethtool -N p5p2 flow-type tcp4 src-ip 192.168.0.2 \
> 				dst-ip 192.168.0.1 action 40
> 	ethtool -N p5p2 flow-type tcp4 src-ip 192.168.0.2 action 41
> 	ethtool -N p5p2 flow-type tcp4 dst-ip 192.168.0.1 action 42
> 	ethtool -N p5p2 flow-type tcp4 dst-port 5001 action 43
>     What to look for to see if side-band filter is matched or not:
> 	Look into port stats (using ethtool -S <ethx> | grep fdir) and
>         specifically look for 'fdir_sb_match'. This counter should be
>         incremented whenever filter is matched.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h         |   6 ++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 116
> +++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    |   2 +-
>  3 files changed, 123 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Flow director filters work and counters propely increment
