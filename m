From: Lan, Tianyu <tianyu.lan@intel.com>
Date: Thu, 26 Nov 2015 00:02:33 +0800
Subject: [Intel-wired-lan] [RFC PATCH V2 3/3] Ixgbevf: Add migration
 support for ixgbevf driver
In-Reply-To: <20151125142437-mutt-send-email-mst@redhat.com>
References: <1448372298-28386-1-git-send-email-tianyu.lan@intel.com>
 <1448372298-28386-4-git-send-email-tianyu.lan@intel.com>
 <20151124230551-mutt-send-email-mst@redhat.com> <56554994.1090305@intel.com>
 <20151125142437-mutt-send-email-mst@redhat.com>
Message-ID: <5655DB99.3040007@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/25/2015 8:28 PM, Michael S. Tsirkin wrote:
> Frankly, I don't really see what this short term hack buys us,
> and if it goes in, we'll have to maintain it forever.
>

The framework of how to notify VF about migration status won't be
changed regardless of stopping VF or not before doing migration.
We hope to reach agreement on this first. Tracking dirty memory still
need to more discussions and we will continue working on it. Stop VF may
help to work around the issue and make tracking easier.


> Also, assuming you just want to do ifdown/ifup for some reason, it's
> easy enough to do using a guest agent, in a completely generic way.
>

Just ifdown/ifup is not enough for migration. It needs to restore some 
PCI settings before doing ifup on the target machine
