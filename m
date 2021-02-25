From: Coiby Xu <coxu@redhat.com>
Date: Thu, 25 Feb 2021 08:21:01 +0800
Subject: [Intel-wired-lan] [RFC PATCH 4/4] i40e: don't open i40iw client
 for kdump
In-Reply-To: <20210224084841.50620776@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210222070701.16416-1-coxu@redhat.com>
 <20210222070701.16416-5-coxu@redhat.com>
 <20210223122207.08835e0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210224114141.ziywca4dvn5fs6js@Rk>
 <20210224084841.50620776@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <20210225002101.hvbpq7f6zbvylqy4@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Feb 24, 2021 at 08:48:41AM -0800, Jakub Kicinski wrote:
>On Wed, 24 Feb 2021 19:41:41 +0800 Coiby Xu wrote:
>> On Tue, Feb 23, 2021 at 12:22:07PM -0800, Jakub Kicinski wrote:
>> >On Mon, 22 Feb 2021 15:07:01 +0800 Coiby Xu wrote:
>> >> i40iw consumes huge amounts of memory. For example, on a x86_64 machine,
>> >> i40iw consumed 1.5GB for Intel Corporation Ethernet Connection X722 for
>> >> for 1GbE while "craskernel=auto" only reserved 160M. With the module
>> >> parameter "resource_profile=2", we can reduce the memory usage of i40iw
>> >> to ~300M which is still too much for kdump.
>> >>
>> >> Disabling the client registration would spare us the client interface
>> >> operation open , i.e., i40iw_open for iwarp/uda device. Thus memory is
>> >> saved for kdump.
>> >>
>> >> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> >
>> >Is i40iw or whatever the client is not itself under a CONFIG which
>> >kdump() kernels could be reasonably expected to disable?
>> >
>>
>> I'm not sure if I understand you correctly. Do you mean we shouldn't
>> disable i40iw for kdump?
>
>Forgive my ignorance - are the kdump kernels separate builds?
>

AFAIK we don't build a kernel exclusively for kdump. 

>If they are it'd be better to leave the choice of enabling RDMA
>to the user - through appropriate Kconfig options.
>

i40iw is usually built as a loadable module. So if we want to leave the
choce of enabling RDMA to the user, we could exclude this driver when
building the initramfs for kdump, for example, dracut provides the 
omit_drivers option for this purpose. 

On the other hand, the users expect "crashkernel=auto" to work out of
the box. So i40iw defeats this purpose. 

I'll discuss with my Red Hat team and the Intel team about whether RDMA
is needed for kdump. Thanks for bringing up this issue!

-- 
Best regards,
Coiby

