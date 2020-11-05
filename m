From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 5 Nov 2020 07:45:11 -0800
Subject: [Intel-wired-lan] [PATCH bpf-next 1/6] i40e: introduce lazy Tx
 completions for AF_XDP zero-copy
In-Reply-To: <CAJ8uoz3-tjXekU=kR+HfMhGBcHtAFnKGq1ZvpFq99T_S-mknPg@mail.gmail.com>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
 <1604498942-24274-2-git-send-email-magnus.karlsson@gmail.com>
 <20201104153320.66cecba8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJ8uoz3-tjXekU=kR+HfMhGBcHtAFnKGq1ZvpFq99T_S-mknPg@mail.gmail.com>
Message-ID: <20201105074511.6935e8b7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 5 Nov 2020 15:17:50 +0100 Magnus Karlsson wrote:
> > I feel like this needs a big fat warning somewhere.
> >
> > It's perfectly fine to never complete TCP packets, but AF_XDP could be
> > used to implement protocols in user space. What if someone wants to
> > implement something like TSQ?  
> 
> I might misunderstand you, but with TSQ here (for something that
> bypasses qdisk and any buffering and just goes straight to the driver)
> you mean the ability to have just a few buffers outstanding and
> continuously reuse these? If so, that is likely best achieved by
> setting a low Tx queue size on the NIC. Note that even without this
> patch, completions could be delayed. Though this patch makes that the
> normal case. In any way, I think this calls for some improved
> documentation.

TSQ tries to limit the amount of data the TCP stack queues into TC/sched
and drivers. Say 1MB ~ 16 GSO frames. It will not queue more data until
some of the transfer is reported as completed. 

IIUC you're allowing up to 64 descriptors to linger without reporting
back that the transfer is done. That means that user space implementing
a scheme similar to TSQ may see its transfers stalled.
