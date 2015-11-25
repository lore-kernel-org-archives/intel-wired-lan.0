From: Lan Tianyu <tianyu.lan@intel.com>
Date: Wed, 25 Nov 2015 13:39:32 +0800
Subject: [Intel-wired-lan] [RFC PATCH V2 3/3] Ixgbevf: Add migration
 support for ixgbevf driver
In-Reply-To: <20151124230551-mutt-send-email-mst@redhat.com>
References: <1448372298-28386-1-git-send-email-tianyu.lan@intel.com>
 <1448372298-28386-4-git-send-email-tianyu.lan@intel.com>
 <20151124230551-mutt-send-email-mst@redhat.com>
Message-ID: <56554994.1090305@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2015?11?25? 05:20, Michael S. Tsirkin wrote:
> I have to say, I was much more interested in the idea
> of tracking dirty memory. I have some thoughts about
> that one - did you give up on it then?

No, our finial target is to keep VF active before doing
migration and tracking dirty memory is essential. But this
seems not easy to do that in short term for upstream. As
starters, stop VF before migration.

After deep thinking, the way of stopping VF still needs tracking
DMA-accessed dirty memory to make sure the received data buffer
before stopping VF migrated. It's easier to do that via dummy writing
data buffer when receive packet.


-- 
Best regards
Tianyu Lan
