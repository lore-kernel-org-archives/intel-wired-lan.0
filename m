From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 14 Apr 2021 19:08:37 -0700
Subject: [Intel-wired-lan] [PATCH net v2] i40e: fix the panic when
 running bpf in xdpdrv mode
In-Reply-To: <CAL+tcoBVhD1SfMYAFVn0HxZ3ig88pxtiLoha9d6Z+62yq8bWBA@mail.gmail.com>
References: <20210412065759.2907-1-kerneljasonxing@gmail.com>
 <20210413025011.1251-1-kerneljasonxing@gmail.com>
 <20210413091812.0000383d@intel.com>
 <CAL+tcoBVhD1SfMYAFVn0HxZ3ig88pxtiLoha9d6Z+62yq8bWBA@mail.gmail.com>
Message-ID: <20210414190837.0000085a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jason Xing wrote:

> On Wed, Apr 14, 2021 at 12:27 AM Jesse Brandeburg
> <jesse.brandeburg@intel.com> wrote:
> >
> > kerneljasonxing at gmail.com wrote:
> >
> > > From: Jason Xing <xingwanli@kuaishou.com>
> >
> > Hi Jason,
> >
> > Sorry, I missed this on the first time: Added intel-wired-lan,
> > please include on any future submissions for Intel drivers.
> > get-maintainers script might help here?
> >
> 
> Probably I got this wrong in the last email. Did you mean that I should add
> intel-wired-lan in the title not the cc list? It seems I should put
> this together on
> the next submission like this:
> 
> [Intel-wired-lan] [PATCH net v4]

Your v3 submittal was correct. My intent was to make sure
intel-wired-lan was in CC:

If Kuba or Dave wants us to take the fix in via intel-wired-lan trees,
then we can do that, or they can apply it directly. I'll ack it on the
v3.

