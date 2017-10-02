From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 2 Oct 2017 16:07:36 +0300
Subject: [Intel-wired-lan] [PATCH 05/18] net: use ARRAY_SIZE
In-Reply-To: <20171001193101.8898-6-jeremy.lefaure@lse.epita.fr>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <20171001193101.8898-6-jeremy.lefaure@lse.epita.fr>
Message-ID: <CAHp75VfC2e+h8GCiB-1Rbe=_z3siBBo0WfqEf3qz8yWh8Cm3RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Oct 1, 2017 at 10:30 PM, J?r?my Lefaure
<jeremy.lefaure@lse.epita.fr> wrote:
> Using the ARRAY_SIZE macro improves the readability of the code. Also,
> it is not always useful to use a variable to store this constant
> calculated at compile time.
>

> +       {&gainctrl_lut_core0_rev0, ARRAY_SIZE(gainctrl_lut_core0_rev0), 26, 192,
> +        32},

For all such cases I would rather put on one line disregard checkpatch
warning for better readability.

-- 
With Best Regards,
Andy Shevchenko
