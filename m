From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 8 Oct 2019 16:54:04 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: protect TX timestamping
 from API misuse
In-Reply-To: <1570288803-14880-1-git-send-email-manjunath.b.patil@oracle.com>
References: <1570288803-14880-1-git-send-email-manjunath.b.patil@oracle.com>
Message-ID: <a53362a9afee4995919c117016209701@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Manjunath Patil
> Sent: Saturday, October 5, 2019 8:20 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net;
> intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Cc: manjunath.b.patil at oracle.com; christophe.jaillet at wanadoo.fr;
> cspradlin at google.com
> Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: protect TX timestamping from
> API misuse
> 
> HW timestamping can only be requested for a packet if the NIC is first setup
> via ioctl(SIOCSHWTSTAMP). If this step was skipped, then the ixgbe driver
> still allowed TX packets to request HW timestamping. In this situation, we see
> 'clearing Tx Timestamp hang' noise in the log.
> 
> Fix this by checking that the NIC is configured for HW TX timestamping before
> accepting a HW TX timestamping request.
> 
> similar-to:
> 	(26bd4e2 igb: protect TX timestamping from API misuse)
> 	(0a6f2f0 igb: Fix a test with HWTSTAMP_TX_ON)
> 
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


