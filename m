From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 8 Aug 2016 23:58:19 +0000
Subject: [Intel-wired-lan] [PATCH v1 2/2] fm10k: don't re-map queues
 when a mailbox message suffices
In-Reply-To: <20160803220528.26222-2-jacob.e.keller@intel.com>
References: <20160803220528.26222-1-jacob.e.keller@intel.com>
 <20160803220528.26222-2-jacob.e.keller@intel.com>
Message-ID: <1470700698.30641.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-08-03 at 15:05 -0700, Jacob Keller wrote:
> When the PF assigns a new MAC Address to a VF, it uses a little
> register
> trick to allow a later load of VF driver access to the MAC Address at
> start without having to wait for a mailbox message. Unfortunately, to
> do
> this the PF must assign ownership of the Queues and take it away from
> the VF, otherwise writing these registers would be unsafe when the VF
> driver is active.
> 
> This causes a potential race where a VF could try to access its
> queues
> while they are owned by the PF. The fault detection code will prevent
> this and issue a FUM fault error when the VF does this.
> 
> We can do better, by simply avoiding the register trick when it's not
> necessary. We already have a mailbox message which indicates the new
> MAC/VLAN pair. The PF currently attempts to send this message and
> ignores failures which happen in the case where VF driver is not
> loaded.
> 
> Fix this logic so that we always send the mailbox message first, then
> if
> the mailbox errors due to no connected VF driver, we will fall back
> to
> the register routine. This prevents using the pre-load method of
> writing
> registers when we have an active VF driver, and thus prevents the
> need
> to take queue ownership back. The whole logic is cleaner and avoids
> the
> messy register interactions that could occur.
> 
> We still keep the register flow so that the PF can ensure a new
> driver
> load will have the MAC Address at start without having to wait for
> the
> PF to send a new mailbox message.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

This patch should not be sent, it has a bug we discovered in testing. I
have a re-worked patch that I will submit shortly.

Thanks,
Jake
