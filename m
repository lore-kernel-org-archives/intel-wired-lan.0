From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 31 Aug 2021 09:19:27 -0700
Subject: [Intel-wired-lan] [RFC v2 net-next 1/2] rtnetlink: Add new
 RTM_GETSYNCESTATE message to get SyncE status
In-Reply-To: <20210830162909.110753ec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210829080512.3573627-1-maciej.machnikowski@intel.com>
 <20210829080512.3573627-2-maciej.machnikowski@intel.com>
 <20210829151017.GA6016@hoboy.vegasvil.org>
 <PH0PR11MB495126A63998DABA5B5DE184EACA9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210830205758.GA26230@hoboy.vegasvil.org>
 <20210830162909.110753ec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <20210831161927.GA10747@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 30, 2021 at 04:29:09PM -0700, Jakub Kicinski wrote:
> Hmm, IDK if this really belongs in RTNL. The OCP time card that
> Jonathan works on also wants to report signal lock, and it locks
> to GNSS. It doesn't have any networking functionality whatsoever.
> 
> Can we add a genetlink family for clock info/configuration? From 
> what I understood discussing this with Jonathan it sounded like most
> clocks today have a vendor-specific character device for configuration
> and reading status.
> 
> I'm happy to write the plumbing if this seems like an okay idea 
> but too much work for anyone to commit.

This sounds nice.

As you said later on in this thread, any API we merge now will have to
last.  That is why I'm being so picky here.  We want new APIs to cover
current HW _and_ be reasonable for the future.

I don't see a DPLL as either a PTP Hardware Clock or a Network
Device.  It is a PLL.

The kernel can and should have a way to represent the relationship
between these three different kind of IP block.  We already have a
way to get from PHC to netdev interface.

I understand that Maciej and team want to get support for their card
ASAP.  However, proper kernel/user API takes time.  For example, the
PHC stuff took one year and fourteen revisions.  But it was worth the
wait, because the API has help up pretty well all these years since
the v3.0 kernel.

There is no need to quickly merge some poorly designed interfaces.

Thanks,
Richard

