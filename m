From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Wed, 14 Aug 2019 08:40:00 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v4 8/8] net/mlx5e: Add AF_XDP
 need_wakeup support
In-Reply-To: <1565767643-4908-9-git-send-email-magnus.karlsson@intel.com>
References: <1565767643-4908-1-git-send-email-magnus.karlsson@intel.com>
 <1565767643-4908-9-git-send-email-magnus.karlsson@intel.com>
Message-ID: <FA76BD00-F81D-453D-AB70-BDE6A4E0950E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 14 Aug 2019, at 0:27, Magnus Karlsson wrote:

> From: Maxim Mikityanskiy <maximmi@mellanox.com>
>
> This commit adds support for the new need_wakeup feature of AF_XDP. The
> applications can opt-in by using the XDP_USE_NEED_WAKEUP bind() flag.
> When this feature is enabled, some behavior changes:
>
> RX side: If the Fill Ring is empty, instead of busy-polling, set the
> flag to tell the application to kick the driver when it refills the Fill
> Ring.
>
> TX side: If there are pending completions or packets queued for
> transmission, set the flag to tell the application that it can skip the
> sendto() syscall and save time.
>
> The performance testing was performed on a machine with the following
> configuration:
>
> - 24 cores of Intel Xeon E5-2620 v3 @ 2.40 GHz
> - Mellanox ConnectX-5 Ex with 100 Gbit/s link
>
> The results with retpoline disabled:
>
>        | without need_wakeup  | with need_wakeup     |
>        |----------------------|----------------------|
>        | one core | two cores | one core | two cores |
> -------|----------|-----------|----------|-----------|
> txonly | 20.1     | 33.5      | 29.0     | 34.2      |
> rxdrop | 0.065    | 14.1      | 12.0     | 14.1      |
> l2fwd  | 0.032    | 7.3       | 6.6      | 7.2       |
>
> "One core" means the application and NAPI run on the same core. "Two
> cores" means they are pinned to different cores.
>
> Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
> Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
> Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
