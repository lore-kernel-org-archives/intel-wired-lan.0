From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 20 Apr 2022 09:36:43 +0300
Subject: [Intel-wired-lan] [PATCH net] ice: Fix race during aux device
 (un)plugging
In-Reply-To: <20220415174932.6c85d5ab@ceranb>
References: <20220414163907.1456925-1-ivecera@redhat.com>
 <CADEbmW3eUAnvn4gvNxqjCMmO333-=OdObGhDXkrTbDwn0YkJDw@mail.gmail.com>
 <20220415174932.6c85d5ab@ceranb>
Message-ID: <Yl+p+7C7JQDj1jt1@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Apr 15, 2022 at 05:49:32PM +0200, Ivan Vecera wrote:
> On Fri, 15 Apr 2022 13:12:03 +0200
> Michal Schmidt <mschmidt@redhat.com> wrote:
> 
> > On Thu, Apr 14, 2022 at 6:39 PM Ivan Vecera <ivecera@redhat.com> wrote:
> > 
> > > Function ice_plug_aux_dev() assigns pf->adev field too early prior
> > > aux device initialization and on other side ice_unplug_aux_dev()
> > > starts aux device deinit and at the end assigns NULL to pf->adev.
> > > This is wrong and can causes a crash when ice_send_event_to_aux()
> > > call occurs during these operations because that function depends
> > > on non-NULL value of pf->adev and does not assume that aux device
> > > is half-initialized or half-destroyed.
> > >
> > > Modify affected functions so pf->adev field is set after aux device
> > > init and prior aux device destroy.
> > >  
> > [...]
> > 
> > > @@ -320,12 +319,14 @@ int ice_plug_aux_dev(struct ice_pf *pf)
> > >   */
> > >  void ice_unplug_aux_dev(struct ice_pf *pf)
> > >  {
> > > -       if (!pf->adev)
> > > +       struct auxiliary_device *adev = pf->adev;
> > > +
> > > +       if (!adev)
> > >                 return;
> > >
> > > -       auxiliary_device_delete(pf->adev);
> > > -       auxiliary_device_uninit(pf->adev);
> > >         pf->adev = NULL;
> > > +       auxiliary_device_delete(adev);
> > > +       auxiliary_device_uninit(adev);
> > >  }
> > >  
> > 
> > Hi Ivan,
> > What prevents ice_unplug_aux_dev() from running immediately after
> > ice_send_event_to_aux() gets past its "if (!pf->adev)" test ?
> > Michal
> 
> ice_send_event_to_aux() takes aux device lock. ice_unplug_aux_dev()
> calls auxiliary_device_delete() that calls device_del(). device_del()
> takes device_lock() prior kill_device(). So if ice_send_event_to_aux()
> is in progress then device_del() waits for its completion.

Not really, you nullify pf->adev without any lock protection and
ice_send_event_to_aux() will simply crash.

 CPU#1          	|   CPU#2
			| ice_send_event_to_aux
 ice_unplug_aux_dev()   | ...
 ...                    | 
 pf->adev = NULL;       | 
      			| device_lock(&pf->adev->dev); <--- crash here.

Thanks


> 
> Thanks,
> Ivan
> 
