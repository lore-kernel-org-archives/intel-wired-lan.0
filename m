From: Andre Guedes <andre.guedes@intel.com>
Date: Mon, 20 Jul 2020 11:27:12 -0700
Subject: [Intel-wired-lan] [PATCH ethtool 0/4] Add support for IGC driver
In-Reply-To: <20200720001046.g7y3p7wrua5qz6i2@lion.mk-sys.cz>
References: <20200707234800.39119-1-andre.guedes@intel.com>
 <20200720001046.g7y3p7wrua5qz6i2@lion.mk-sys.cz>
Message-ID: <159526963226.8351.8054617544521796564@jrmontoy-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Michal,

Quoting Michal Kubecek (2020-07-19 17:10:46)
> On Tue, Jul 07, 2020 at 04:47:56PM -0700, Andre Guedes wrote:
> > Hi all,
> > 
> > This patch series adds support for parsing registers dumped by the IGC driver.
> > For now, the following registers are parsed:
> > 
> >       * Receive Address Low (RAL)
> >       * Receive Address High (RAH)
> >       * Receive Control (RCTL)
> >       * VLAN Priority Queue Filter (VLANPQF)
> >       * EType Queue Filter (ETQF)
> > 
> > More registers should be parsed as we need/enable them.
> > 
> > Cheers,
> > Andre
> 
> Series merged. But please consider making the output consistent with
> other Intel drivers which use lowercase keywords for values (e.g.
> "enabled") and "yes"/"no" for bool values (rather than "True" / "False").

Sure, I'll send a patch aligning this.

- Andre
