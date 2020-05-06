From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Wed, 6 May 2020 15:30:30 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next pre-v1 MAXONLY 05/14] i40e:
 refactor rx_bi accesses
In-Reply-To: <20200506132746.526188-6-bjorn.topel@gmail.com>
References: <20200506132746.526188-1-bjorn.topel@gmail.com>
 <20200506132746.526188-6-bjorn.topel@gmail.com>
Message-ID: <CAJ+HfNg4KkiqpG8Kgz9wuSSnZFpZaH_2F9HYLyXo4AGGe-PAGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 6 May 2020 at 15:28, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
> From: Bj?rn T?pel <bjorn.topel@intel.com>
>
> As a first step to migrate i40e to the new MEM_TYPE_XSK_BUFF_POOL
> APIs, code that accesses the rx_bi (SW/shadow ring) is refactored to
> use an accessor function.
>

And c**p. So much for "no Cc". Sorry for the noise intel-wired-lan.


Bj?rn
