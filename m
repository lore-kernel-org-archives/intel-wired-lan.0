From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 7 Mar 2018 11:58:52 -0500
Subject: [Intel-wired-lan] [RFC v3 net-next 01/18] sock: Fix SO_ZEROCOPY
 switch case
In-Reply-To: <20180307011230.24001-2-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-2-jesus.sanchez-palencia@intel.com>
Message-ID: <CAF=yD-JWq9xNQqMV9aFG11wdemPfCnvOy=G=tvEWBMWgex5xYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 6, 2018 at 8:12 PM, Jesus Sanchez-Palencia
<jesus.sanchez-palencia@intel.com> wrote:
> Fix the SO_ZEROCOPY switch case on sock_setsockopt() avoiding the
> ret values to be overwritten by the one set on the default case.
>
> Fixes: 28190752c7092 ("sock: permit SO_ZEROCOPY on PF_RDS socket")
> Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>

Acked-by: Willem de Bruijn <willemb@google.com>

Please send this fix to net-next independent from the rest of the patchset.
