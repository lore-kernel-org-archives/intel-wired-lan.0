From: Joe Perches <joe@perches.com>
Date: Thu, 14 Jan 2021 02:55:13 -0800
Subject: [Intel-wired-lan] [net-next] net: iavf: Use the ARRAY_SIZE
 macro for aq_to_posix
In-Reply-To: <CY4PR11MB15769D5697074F230C8742CAABA80@CY4PR11MB1576.namprd11.prod.outlook.com>
References: <1599641471-204919-1-git-send-email-xuwei5@hisilicon.com>
 <CY4PR11MB15769D5697074F230C8742CAABA80@CY4PR11MB1576.namprd11.prod.outlook.com>
Message-ID: <ff6c529f78396aa3ce8d9cb9fefeeb098e64342f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-01-14 at 09:57 +0000, Jankowski, Konrad0 wrote:
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Wei Xu
[]
> > Use the ARRAY_SIZE macro to calculate the size of an array.
> > This code was detected with the help of Coccinelle.
[]
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h
[]
> > @@ -120,7 +120,7 @@ static inline int iavf_aq_rc_to_posix(int aq_ret, int aq_rc)
> > ?	if (aq_ret == IAVF_ERR_ADMIN_QUEUE_TIMEOUT)
> > ?		return -EAGAIN;
> > 
> > -	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
> > +	if (!((u32)aq_rc < ARRAY_SIZE(aq_to_posix)))
> > ?		return -ERANGE;
> > 
> > ?	return aq_to_posix[aq_rc];
> 
> Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

I think several things are poor here.

This function shouldn't really be a static inline as it would just bloat
whatever uses it and should just be a typical function in a utility .c file.

And it doesn't seem this function is used at all so it should be deleted.

aq_to_posix should be static const.

And if it's really necessary, I think it would be simpler to read using code
without the cast and negation.

	if (aq_rc < 0 || aq_rc >= ARRAY_SIZE(aq_to_posix))
		return -ERANGE;



