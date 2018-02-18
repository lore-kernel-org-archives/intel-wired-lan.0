From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 18 Feb 2018 16:58:12 +0200
Subject: [Intel-wired-lan] [PATCH] i40evf: remove redundant array
 comparisons to 0 checks
In-Reply-To: <eb8a38bd-73a0-5f44-5e89-d9ded5be1800@canonical.com>
References: <20180215194245.28860-1-colin.king@canonical.com>
 <CAHp75Vcxt0kkzRaF1Zzkt4hVqcPt0VG61yTLgB7HvG1xwhPUbg@mail.gmail.com>
 <eb8a38bd-73a0-5f44-5e89-d9ded5be1800@canonical.com>
Message-ID: <CAHp75VcsV4NfR3OiAjjYAowcHmK+rXOsrPN2aHnxBp5hqg+C+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Feb 16, 2018 at 6:53 PM, Colin Ian King
<colin.king@canonical.com> wrote:
> On 16/02/18 16:51, Andy Shevchenko wrote:
>> On Thu, Feb 15, 2018 at 9:42 PM, Colin King <colin.king@canonical.com> wrote:

>>> +                       filter->f.mask.tcp_spec.dst_ip[i] |=
>>>                                                         cpu_to_be32(0xffffffff);
>>
>> Can it be one line then?
>
> I re-adjusted the text because checkpatch was complaining.

>>
>>> +                       filter->f.mask.tcp_spec.src_ip[i] |=
>>>                                                         cpu_to_be32(0xffffffff);

For the rest OK, but for the above two how much over 80 it went if
would be one line?
If it 2-3 characters, consider to make it one line. It would increase
readability.

-- 
With Best Regards,
Andy Shevchenko
