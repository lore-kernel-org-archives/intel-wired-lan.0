From: =?unknown-8bit?q?J=C3=A9r=C3=A9my?= Lefaure <jeremy.lefaure@lse.epita.fr>
Date: Mon, 2 Oct 2017 21:22:14 -0400
Subject: [Intel-wired-lan] [PATCH 05/18] net: use ARRAY_SIZE
In-Reply-To: <CAHp75VfC2e+h8GCiB-1Rbe=_z3siBBo0WfqEf3qz8yWh8Cm3RQ@mail.gmail.com>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <20171001193101.8898-6-jeremy.lefaure@lse.epita.fr>
 <CAHp75VfC2e+h8GCiB-1Rbe=_z3siBBo0WfqEf3qz8yWh8Cm3RQ@mail.gmail.com>
Message-ID: <20171002212214.30d7013a@blatinox-laptop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2 Oct 2017 16:07:36 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> > +       {&gainctrl_lut_core0_rev0, ARRAY_SIZE(gainctrl_lut_core0_rev0), 26, 192,
> > +        32},  
> 
> For all such cases I would rather put on one line disregard checkpatch
> warning for better readability.
I agree that it would be better. I didn't know that it was possible to
not follow this rule for anything else than a string.

I am waiting for more comments and I will send a v2.

Thank you,
J?r?my
