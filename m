From: Ivan Vecera <ivecera@redhat.com>
Date: Wed, 20 Apr 2022 15:59:42 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: Fix race during aux device
 (un)plugging
In-Reply-To: <Yl+p+7C7JQDj1jt1@unreal>
References: <20220414163907.1456925-1-ivecera@redhat.com>
 <CADEbmW3eUAnvn4gvNxqjCMmO333-=OdObGhDXkrTbDwn0YkJDw@mail.gmail.com>
 <20220415174932.6c85d5ab@ceranb> <Yl+p+7C7JQDj1jt1@unreal>
Message-ID: <20220420155942.545b7f58@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 20 Apr 2022 09:36:43 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> > ice_send_event_to_aux() takes aux device lock. ice_unplug_aux_dev()
> > calls auxiliary_device_delete() that calls device_del(). device_del()
> > takes device_lock() prior kill_device(). So if ice_send_event_to_aux()
> > is in progress then device_del() waits for its completion.  
> 
> Not really, you nullify pf->adev without any lock protection and
> ice_send_event_to_aux() will simply crash.
> 
>  CPU#1          	|   CPU#2
> 			| ice_send_event_to_aux
>  ice_unplug_aux_dev()   | ...
>  ...                    | 
>  pf->adev = NULL;       | 
>       			| device_lock(&pf->adev->dev); <--- crash here.
> 
> Thanks

You are right, the window is very tiny but it's still there.
Will send v2.

Thanks,
Ivan

