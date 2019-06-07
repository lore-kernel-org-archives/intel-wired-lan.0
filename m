From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Fri, 7 Jun 2019 15:34:52 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 4/6] taprio: Add support
 for txtime-assist mode.
In-Reply-To: <0ED5E88B-E95A-4899-975D-00912685CEEF@intel.com>
References: <1559843458-12517-1-git-send-email-vedang.patel@intel.com>
 <1559843458-12517-5-git-send-email-vedang.patel@intel.com>
 <20190606162132.0591cc37@cakuba.netronome.com>
 <FF3C8B8E-421E-4C93-8895-C21A38BB55EE@intel.com>
 <20190607150243.369f6e2c@cakuba.netronome.com>
 <0ED5E88B-E95A-4899-975D-00912685CEEF@intel.com>
Message-ID: <20190607153452.53885f87@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 7 Jun 2019 22:27:07 +0000, Patel, Vedang wrote:
> Hi Jacub, 
> 
> > On Jun 7, 2019, at 3:02 PM, Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
> > 
> > On Fri, 7 Jun 2019 20:42:55 +0000, Patel, Vedang wrote:  
> >>> Thanks for the changes, since you now validate no unknown flags are
> >>> passed, perhaps there is no need to check if flags are == ~0?
> >>> 
> >>> IS_ENABLED() could just do: (flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST
> >>> No?
> >>>   
> >> This is specifically done so that user does not have to specify the
> >> offload flags when trying to install the another schedule which will
> >> be switched to at a later point of time (i.e. the admin schedule
> >> introduced in Vinicius? last series). Setting taprio_flags to ~0
> >> will help us distinguish between the flags parameter not specified
> >> and flags set to 0.  
> > 
> > I'm not super clear on this, because of backward compat you have to
> > treat attr not present as unset.  Let's see:
> > 
> > new qdisc:
> > - flags attr = 0 -> txtime not used
> > - flags attr = 1 -> txtime used  
> > -> no flags attr -> txtime not used  
> > change qdisc:
> > - flags attr = old flags attr -> leave unchanged
> > - flags attr != old flags attr -> error
> > - no flags attr -> leave txtime unchanged
> > 
> > Doesn't that cover the cases?  Were you planning to have no flag attr
> > on change mean disabled rather than no change?  
> 
> You covered all the cases above.
> 
> Thinking a bit more about it, yes you are right. Initiializing flags
> to 0 will work.  I will incorporate this change in the next version.

Cool, thanks!  

FWIW I think historically TC used to require all parameters specified
and assumed 0 rather than not changed, but I think that was because C
structs were passed as blobs instead of breaking things out per attr.
So today I think its better to make full use of attrs and assume not
present to mean not changed ?
