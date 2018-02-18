From: Colin Ian King <colin.king@canonical.com>
Date: Sun, 18 Feb 2018 19:00:34 +0000
Subject: [Intel-wired-lan] [PATCH] i40evf: remove redundant array
 comparisons to 0 checks
In-Reply-To: <1518971510.1894.2.camel@perches.com>
References: <20180215194245.28860-1-colin.king@canonical.com>
 <CAHp75Vcxt0kkzRaF1Zzkt4hVqcPt0VG61yTLgB7HvG1xwhPUbg@mail.gmail.com>
 <eb8a38bd-73a0-5f44-5e89-d9ded5be1800@canonical.com>
 <CAHp75VcsV4NfR3OiAjjYAowcHmK+rXOsrPN2aHnxBp5hqg+C+g@mail.gmail.com>
 <1518971510.1894.2.camel@perches.com>
Message-ID: <28e69707-9f10-451b-9218-8246238a9958@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 18/02/18 16:31, Joe Perches wrote:
> On Sun, 2018-02-18 at 16:58 +0200, Andy Shevchenko wrote:
>> On Fri, Feb 16, 2018 at 6:53 PM, Colin Ian King
>> <colin.king@canonical.com> wrote:
>>> On 16/02/18 16:51, Andy Shevchenko wrote:
>>>> On Thu, Feb 15, 2018 at 9:42 PM, Colin King <colin.king@canonical.com> wrote:
>>>>> +                       filter->f.mask.tcp_spec.dst_ip[i] |=
>>>>>                                                         cpu_to_be32(0xffffffff);
>>>>
>>>> Can it be one line then?
>>>
>>> I re-adjusted the text because checkpatch was complaining.
>>>>
>>>>> +                       filter->f.mask.tcp_spec.src_ip[i] |=
>>>>>                                                         cpu_to_be32(0xffffffff);
>>
>> For the rest OK, but for the above two how much over 80 it went if
>> would be one line?
>> If it 2-3 characters, consider to make it one line. It would increase
>> readability.
> 
> Another possibility would be to use temporaries for
> 	filter->f.mask.tcp_spec
> and
> 	filter->f.data.tcp_spec
> as both are used ~10 times in the function

That's a good idea. I'll fix this up tomorrow when I get back to work
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

