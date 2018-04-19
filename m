From: Steffen Klassert <steffen.klassert@secunet.com>
Date: Thu, 19 Apr 2018 08:54:36 +0200
Subject: [Intel-wired-lan] [net] udp: enable UDP checksum offload for ESP
In-Reply-To: <20180412190315.3102-1-jacek.kalwas@intel.com>
References: <20180412190315.3102-1-jacek.kalwas@intel.com>
Message-ID: <20180419065436.vxlnorotd6xpy46f@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 12, 2018 at 12:03:13PM -0700, Jacek Kalwas wrote:
> In case NIC has support for ESP TX CSUM offload skb->ip_summed is not
> set to CHECKSUM_PARTIAL which results in checksum calculated by SW.
> 
> Fix enables ESP TX CSUM for UDP by extending condition with check for
> NETIF_F_HW_ESP_TX_CSUM.
> 
> Signed-off-by: Jacek Kalwas <jacek.kalwas@intel.com>

Applied to ipsec-next, thanks!
