From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 18 Apr 2016 19:43:22 +0000
Subject: [Intel-wired-lan] [next PATCH S34 05/12] i40e: Flow-based
 side-band	filter count and its use for input set change
In-Reply-To: <1460542112-20166-6-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460542112-20166-6-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D0F59@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Wednesday, April 13, 2016 3:08 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S34 05/12] i40e: Flow-based side-band
> filter count and its use for input set change
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> This patch keeps track of side-band filters based on flow-type.
> It is used to handle detection of input set mask changes per flow-type.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-Id: I5f308dbd33d3c6ae9f5db301b5989b6089f61dce
> ---
> Testing Hints :
> 	ethtool -N p5p2 flow-type tcp4 src-ip 192.168.0.2 \
> 		 dst-ip 192.168.0.1 action 40
> 	ethtool -N p5p2 flow-type udp4 src-ip 192.168.0.2 \
> 		 dst-ip 192.168.0.1 src-port 1000 action 41 Made sure that,
> able to change input set mask independently based on flow-type.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h         |  9 +++++++++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  9 +++++++--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 24
> +++++++++++++++++++++---
>  3 files changed, 37 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Side band filters input set mask can be changed independently based on flow type
