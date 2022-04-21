From: Ivan Vecera <ivecera@redhat.com>
Date: Thu, 21 Apr 2022 08:08:48 +0200
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix race during aux
 device (un)plugging
In-Reply-To: <YmDn2ptpRHasOQag@unreal>
References: <20220420150300.1062689-1-ivecera@redhat.com>
 <YmDn2ptpRHasOQag@unreal>
Message-ID: <20220421080848.41bed123@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 21 Apr 2022 08:12:58 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> >  static struct iidc_auxiliary_drv *ice_get_auxiliary_drv(struct ice_pf *pf)
> >  {
> >  	struct auxiliary_device *adev;
> >  
> > +	BUG_ON(!mutex_is_locked(&pf->adev_mutex));  
> 
> Please don't add BUG_ON() in driver code.
> 
> I think that you are looking for lockdep_assert_held(&pf->adev_mutex).

Will fix.

I.

