From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Fri, 7 Jun 2019 15:02:43 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 4/6] taprio: Add support
 for txtime-assist mode.
In-Reply-To: <FF3C8B8E-421E-4C93-8895-C21A38BB55EE@intel.com>
References: <1559843458-12517-1-git-send-email-vedang.patel@intel.com>
 <1559843458-12517-5-git-send-email-vedang.patel@intel.com>
 <20190606162132.0591cc37@cakuba.netronome.com>
 <FF3C8B8E-421E-4C93-8895-C21A38BB55EE@intel.com>
Message-ID: <20190607150243.369f6e2c@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 7 Jun 2019 20:42:55 +0000, Patel, Vedang wrote:
> > Thanks for the changes, since you now validate no unknown flags are
> > passed, perhaps there is no need to check if flags are == ~0?
> > 
> > IS_ENABLED() could just do: (flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST
> > No?
> >   
> This is specifically done so that user does not have to specify the
> offload flags when trying to install the another schedule which will
> be switched to at a later point of time (i.e. the admin schedule
> introduced in Vinicius? last series). Setting taprio_flags to ~0
> will help us distinguish between the flags parameter not specified
> and flags set to 0.

I'm not super clear on this, because of backward compat you have to
treat attr not present as unset.  Let's see:

new qdisc:
 - flags attr = 0 -> txtime not used
 - flags attr = 1 -> txtime used
 -> no flags attr -> txtime not used
change qdisc:
 - flags attr = old flags attr -> leave unchanged
 - flags attr != old flags attr -> error
 - no flags attr -> leave txtime unchanged

Doesn't that cover the cases?  Were you planning to have no flag attr
on change mean disabled rather than no change?
