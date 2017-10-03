From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 3 Oct 2017 11:09:50 +0300
Subject: [Intel-wired-lan] [PATCH 05/18] net: use ARRAY_SIZE
In-Reply-To: <20171002212214.30d7013a@blatinox-laptop.localdomain>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <20171001193101.8898-6-jeremy.lefaure@lse.epita.fr>
 <CAHp75VfC2e+h8GCiB-1Rbe=_z3siBBo0WfqEf3qz8yWh8Cm3RQ@mail.gmail.com>
 <20171002212214.30d7013a@blatinox-laptop.localdomain>
Message-ID: <CAHp75Vfz=77TB3Mt_=CZUBzndwRE_XhrOFgdJ-HLUwrfg8a=kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 3, 2017 at 4:22 AM, J?r?my Lefaure
<jeremy.lefaure@lse.epita.fr> wrote:
> On Mon, 2 Oct 2017 16:07:36 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>> > +       {&gainctrl_lut_core0_rev0, ARRAY_SIZE(gainctrl_lut_core0_rev0), 26, 192,
>> > +        32},
>>
>> For all such cases I would rather put on one line disregard checkpatch
>> warning for better readability.
> I agree that it would be better. I didn't know that it was possible to
> not follow this rule for anything else than a string.

IMO, it increases readability quite enough to overrule checkpatch recomendation.

-- 
With Best Regards,
Andy Shevchenko
