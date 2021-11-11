From: Florian Westphal <fw@strlen.de>
Date: Thu, 11 Nov 2021 17:22:52 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 2/6] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <YY0+PmNU4MSGfgqA@hog>
References: <20211110114448.2792314-1-maciej.machnikowski@intel.com>
 <20211110114448.2792314-3-maciej.machnikowski@intel.com>
 <YY0+PmNU4MSGfgqA@hog>
Message-ID: <20211111162252.GJ16363@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sabrina Dubroca <sd@queasysnail.net> wrote:
> Hello Maciej,
> 
> 2021-11-10, 12:44:44 +0100, Maciej Machnikowski wrote:
> > diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> > index 5888492a5257..1d8662afd6bd 100644
> > --- a/include/uapi/linux/rtnetlink.h
> > +++ b/include/uapi/linux/rtnetlink.h
> > @@ -185,6 +185,9 @@ enum {
> >  	RTM_GETNEXTHOPBUCKET,
> >  #define RTM_GETNEXTHOPBUCKET	RTM_GETNEXTHOPBUCKET
> >  
> > +	RTM_GETEECSTATE = 124,
> > +#define RTM_GETEECSTATE	RTM_GETEECSTATE
> 
> I'm not sure about this. All the other RTM_GETxxx are such that
> RTM_GETxxx % 4 == 2. Following the current pattern, 124 should be
> reserved for RTM_NEWxxx, and RTM_GETEECSTATE would be 126.

More importantly, why is this added to rtnetlink (routing sockets)?
It appears to be unrelated?

Looks like this should be in ethtool (it has netlink api nowadays) or
devlink.
