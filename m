From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Wed, 14 Aug 2019 07:49:07 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v4 5/8] libbpf: add support
 for need_wakeup flag in AF_XDP part
In-Reply-To: <1565767643-4908-6-git-send-email-magnus.karlsson@intel.com>
References: <1565767643-4908-1-git-send-email-magnus.karlsson@intel.com>
 <1565767643-4908-6-git-send-email-magnus.karlsson@intel.com>
Message-ID: <CF4AFFE2-D7F3-4C2E-BD31-42441B553EC5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 14 Aug 2019, at 0:27, Magnus Karlsson wrote:

> This commit adds support for the new need_wakeup flag in AF_XDP. The
> xsk_socket__create function is updated to handle this and a new
> function is introduced called xsk_ring_prod__needs_wakeup(). This
> function can be used by the application to check if Rx and/or Tx
> processing needs to be explicitly woken up.
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
