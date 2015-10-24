From: Lan, Tianyu <tianyu.lan@intel.com>
Date: Sun, 25 Oct 2015 00:08:08 +0800
Subject: [Intel-wired-lan] [RFC Patch 08/12] IXGBEVF: Rework code of
 finding the end transmit desc of package
In-Reply-To: <20151022155650-mutt-send-email-mst@redhat.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <1445445464-5056-9-git-send-email-tianyu.lan@intel.com>
 <20151022155650-mutt-send-email-mst@redhat.com>
Message-ID: <562BACE8.8070507@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 10/22/2015 8:58 PM, Michael S. Tsirkin wrote:
> Do you really need to play the shifting games?
> Can't you just reset everything and re-initialize the rings?
> It's slower but way less intrusive.
> Also removes the need to track writes into rings.

Shift ring is to avoid losing those packets in the ring.
This may cause some race condition and so I introduced a
lock to prevent such cases in the latter patch.
Yes, reset everything after migration can make thing easy.
But just like you said it would affect performance and loss
more packets. I can do a test later to get data about these
two way.

