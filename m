From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 31 Aug 2021 18:58:24 -0700
Subject: [Intel-wired-lan] [RFC v2 net-next 1/2] rtnetlink: Add new
 RTM_GETSYNCESTATE message to get SyncE status
In-Reply-To: <20210831161927.GA10747@hoboy.vegasvil.org>
References: <20210829080512.3573627-1-maciej.machnikowski@intel.com>
 <20210829080512.3573627-2-maciej.machnikowski@intel.com>
 <20210829151017.GA6016@hoboy.vegasvil.org>
 <PH0PR11MB495126A63998DABA5B5DE184EACA9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210830205758.GA26230@hoboy.vegasvil.org>
 <20210830162909.110753ec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210831161927.GA10747@hoboy.vegasvil.org>
Message-ID: <20210831185824.5021e847@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 31 Aug 2021 09:19:27 -0700 Richard Cochran wrote:
> As you said later on in this thread, any API we merge now will have to
> last.  That is why I'm being so picky here.  We want new APIs to cover
> current HW _and_ be reasonable for the future.
> 
> I don't see a DPLL as either a PTP Hardware Clock or a Network
> Device.  It is a PLL.
> 
> The kernel can and should have a way to represent the relationship
> between these three different kind of IP block.  We already have a
> way to get from PHC to netdev interface.

Makes sense to me. I was wondering how to split things at high level
into the areas you mentioned, but TBH the part I'm struggling with is
the delineation of what falls under PTP. PLL by itself seems like an
awfully small unit to create a subsystem for, and PTP already has aux
stuff like PIN control. Then there's the whole bunch of stuff that Jonathan
is adding via driver specific sysfs interfaces [1]. I was hoping the
"new API" would cover his need but PLL would be a tiny part of it.

IOW after looking at the code I'm not so sure how to reasonably divide
things.

[1]
https://lore.kernel.org/netdev/20210830235236.309993-1-jonathan.lemon at gmail.com/
