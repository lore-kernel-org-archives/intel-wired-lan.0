From: Coiby Xu <coxu@redhat.com>
Date: Wed, 3 Mar 2021 17:44:58 +0800
Subject: [Intel-wired-lan] [RFC PATCH 4/4] i40e: don't open i40iw client
 for kdump
In-Reply-To: <CAFTCetS=G_JV4Ax6=Ty20uifoL1jscrqPGhdh7d2k+t=0d+L8g@mail.gmail.com>
References: <20210222070701.16416-1-coxu@redhat.com>
 <20210222070701.16416-5-coxu@redhat.com>
 <CAFTCetS=G_JV4Ax6=Ty20uifoL1jscrqPGhdh7d2k+t=0d+L8g@mail.gmail.com>
Message-ID: <20210303094458.7yootsa5dvn5cnba@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Bhupesh,

Glad to meet you here:)

On Thu, Feb 25, 2021 at 03:41:55PM +0530, Bhupesh SHARMA wrote:
>Hello Coiby,
>
>On Mon, Feb 22, 2021 at 12:40 PM Coiby Xu <coxu@redhat.com> wrote:
>>
>> i40iw consumes huge amounts of memory. For example, on a x86_64 machine,
>> i40iw consumed 1.5GB for Intel Corporation Ethernet Connection X722 for
>> for 1GbE while "craskernel=auto" only reserved 160M. With the module
>> parameter "resource_profile=2", we can reduce the memory usage of i40iw
>> to ~300M which is still too much for kdump.
>>
>> Disabling the client registration would spare us the client interface
>> operation open , i.e., i40iw_open for iwarp/uda device. Thus memory is
>> saved for kdump.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e_client.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
>> index a2dba32383f6..aafc2587f389 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
>> @@ -4,6 +4,7 @@
>>  #include <linux/list.h>
>>  #include <linux/errno.h>
>>  #include <linux/net/intel/i40e_client.h>
>> +#include <linux/crash_dump.h>
>>
>>  #include "i40e.h"
>>  #include "i40e_prototype.h"
>> @@ -741,6 +742,12 @@ int i40e_register_client(struct i40e_client *client)
>>  {
>>         int ret = 0;
>>
>> +       /* Don't open i40iw client for kdump because i40iw will consume huge
>> +        * amounts of memory.
>> +        */
>> +       if (is_kdump_kernel())
>> +               return ret;
>> +
>
>Since crashkernel size can be manually set on the command line by a
>user, and some users might be fine with a ~300M memory usage by i40iw
>client [with resource_profile=2"], in my view, disabling the client
>for all kdump cases seems too restrictive.
>
>We can probably check the crash kernel size allocated (
>$ cat /sys/kernel/kexec_crash_size) and then make a decision
>accordingly, so for example something like:
>
> +       if (is_kdump_kernel() && kexec_crash_size < 512M)
> +               return ret;
>
>What do you think?
>

Thanks for the suggestion! After having a discussion with the team, we
think it's better to not intervene i40iw in the kernel space. Actually 
when kexec-tools is building initramfs for kdump, i40iw is not included 
by default unless a user explicitly asks to include i40iw by changing 
/etc/kdump.conf, i.e., adding 'dracut_args --add-drivers "i40iw"'.


>Regards,
>Bhupesh
>
>>         if (!client) {
>>                 ret = -EIO;
>>                 goto out;
>> --
>> 2.30.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>

-- 
Best regards,
Coiby

