From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 24 Feb 2021 16:47:20 -0800
Subject: [Intel-wired-lan] [RFC PATCH 4/4] i40e: don't open i40iw client
 for kdump
In-Reply-To: <20210225002101.hvbpq7f6zbvylqy4@Rk>
References: <20210222070701.16416-1-coxu@redhat.com>
 <20210222070701.16416-5-coxu@redhat.com>
 <20210223122207.08835e0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210224114141.ziywca4dvn5fs6js@Rk>
 <20210224084841.50620776@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210225002101.hvbpq7f6zbvylqy4@Rk>
Message-ID: <20210224164720.2228c580@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 25 Feb 2021 08:21:01 +0800 Coiby Xu wrote:
> On Wed, Feb 24, 2021 at 08:48:41AM -0800, Jakub Kicinski wrote:
> >On Wed, 24 Feb 2021 19:41:41 +0800 Coiby Xu wrote:  
> >> I'm not sure if I understand you correctly. Do you mean we shouldn't
> >> disable i40iw for kdump?  
> >
> >Forgive my ignorance - are the kdump kernels separate builds?
> 
> AFAIK we don't build a kernel exclusively for kdump. 
> 
> >If they are it'd be better to leave the choice of enabling RDMA
> >to the user - through appropriate Kconfig options.
> 
> i40iw is usually built as a loadable module. So if we want to leave the
> choce of enabling RDMA to the user, we could exclude this driver when
> building the initramfs for kdump, for example, dracut provides the 
> omit_drivers option for this purpose. 
> 
> On the other hand, the users expect "crashkernel=auto" to work out of
> the box. So i40iw defeats this purpose. 
> 
> I'll discuss with my Red Hat team and the Intel team about whether RDMA
> is needed for kdump. Thanks for bringing up this issue!

Great, talking to experts here at FB it seems that building a cut-down
kernel for kdump is easier than chasing all the drivers to react to
is_kdump_kernel(). But if you guys need it and Intel is fine with 
the change I won't complain.
