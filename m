From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 29 Sep 2021 17:20:01 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 0/5] Devlink reload and
 missed notifications fix
In-Reply-To: <20210929065621.20cb08ad@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1632916329.git.leonro@nvidia.com>
 <20210929064004.3172946e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210929134637.4wlbd5ehbgc55cuo@skbuf>
 <20210929065621.20cb08ad@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <YVR2EYrklpj+CSfo@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 29, 2021 at 06:56:21AM -0700, Jakub Kicinski wrote:
> On Wed, 29 Sep 2021 13:46:38 +0000 Vladimir Oltean wrote:
> > On Wed, Sep 29, 2021 at 06:40:04AM -0700, Jakub Kicinski wrote:
> > > Swapping ops is a nasty hack in my book.
> > >
> > > And all that to avoid having two op structures in one driver.
> > > Or to avoid having counters which are always 0?
> > >
> > > Sorry, at the very least you need better explanation for this.  
> > 
> > Leon, while the discussion about this unfolds, can you please repost
> > patch 1 separately? :)
> 
> Yes, please and thanks! :)

Done, thanks
https://lore.kernel.org/netdev/2ed1159291f2a589b013914f2b60d8172fc525c1.1632925030.git.leonro at nvidia.com/T/#u
