From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 15 Apr 2021 13:16:22 +0800
Subject: [Intel-wired-lan] [PATCH net v2] i40e: fix the panic when
 running bpf in xdpdrv mode
In-Reply-To: <20210414190837.0000085a@intel.com>
References: <20210412065759.2907-1-kerneljasonxing@gmail.com>
 <20210413025011.1251-1-kerneljasonxing@gmail.com>
 <20210413091812.0000383d@intel.com>
 <CAL+tcoBVhD1SfMYAFVn0HxZ3ig88pxtiLoha9d6Z+62yq8bWBA@mail.gmail.com>
 <20210414190837.0000085a@intel.com>
Message-ID: <CAL+tcoAfVCJMgeVFnyHaZhEEJRiWEYc5hm5c0GOKwg2BDiVtYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 15, 2021 at 10:08 AM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> Jason Xing wrote:
>
> > On Wed, Apr 14, 2021 at 12:27 AM Jesse Brandeburg
> > <jesse.brandeburg@intel.com> wrote:
> > >
> > > kerneljasonxing at gmail.com wrote:
> > >
> > > > From: Jason Xing <xingwanli@kuaishou.com>
> > >
> > > Hi Jason,
> > >
> > > Sorry, I missed this on the first time: Added intel-wired-lan,
> > > please include on any future submissions for Intel drivers.
> > > get-maintainers script might help here?
> > >
> >
> > Probably I got this wrong in the last email. Did you mean that I should add
> > intel-wired-lan in the title not the cc list? It seems I should put
> > this together on
> > the next submission like this:
> >
> > [Intel-wired-lan] [PATCH net v4]
>
> Your v3 submittal was correct. My intent was to make sure
> intel-wired-lan was in CC:
>

Well, I get to know more about the whole thing.

> If Kuba or Dave wants us to take the fix in via intel-wired-lan trees,
> then we can do that, or they can apply it directly. I'll ack it on the
> v3.

Thanks, Jesse:)

Jason

>
