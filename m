From: Lan, Tianyu <tianyu.lan@intel.com>
Date: Sun, 25 Oct 2015 00:12:23 +0800
Subject: [Intel-wired-lan] [RFC Patch 08/12] IXGBEVF: Rework code of
 finding the end transmit desc of package
In-Reply-To: <56280050.9020301@gmail.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <1445445464-5056-9-git-send-email-tianyu.lan@intel.com>
 <56280050.9020301@gmail.com>
Message-ID: <562BADE7.4010105@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/22/2015 5:14 AM, Alexander Duyck wrote:
> Where is i being initialized?  It was here but you removed it.  Are you
> using i without initializing it?

Sorry, the initialization was put into patch 10 by mistake. "i" is
assigned with "tx_ring->next_to_clean".
