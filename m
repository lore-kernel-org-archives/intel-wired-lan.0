From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Wed, 14 Aug 2019 08:41:29 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v4 3/8] i40e: add support for
 AF_XDP need_wakeup feature
In-Reply-To: <1565767643-4908-4-git-send-email-magnus.karlsson@intel.com>
References: <1565767643-4908-1-git-send-email-magnus.karlsson@intel.com>
 <1565767643-4908-4-git-send-email-magnus.karlsson@intel.com>
Message-ID: <DA842C18-42DF-4559-A746-F0B428B3CAB5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 14 Aug 2019, at 0:27, Magnus Karlsson wrote:

> This patch adds support for the need_wakeup feature of AF_XDP. If the
> application has told the kernel that it might sleep using the new bind
> flag XDP_USE_NEED_WAKEUP, the driver will then set this flag if it has
> no more buffers on the NIC Rx ring and yield to the application. For
> Tx, it will set the flag if it has no outstanding Tx completion
> interrupts and return to the application.
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
