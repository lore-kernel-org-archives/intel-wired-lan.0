From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Wed, 14 Aug 2019 07:53:51 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v4 7/8] net/mlx5e: Move the
 SW XSK code from NAPI poll to a separate function
In-Reply-To: <1565767643-4908-8-git-send-email-magnus.karlsson@intel.com>
References: <1565767643-4908-1-git-send-email-magnus.karlsson@intel.com>
 <1565767643-4908-8-git-send-email-magnus.karlsson@intel.com>
Message-ID: <52303412-E8CB-4F34-A41D-4CDE12D719CA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 14 Aug 2019, at 0:27, Magnus Karlsson wrote:

> From: Maxim Mikityanskiy <maximmi@mellanox.com>
>
> Two XSK tasks are performed during NAPI polling, that are not bound to
> hardware interrupts: TXing packets and polling for frames in the Fill
> Ring. They are special in a way that the hardware doesn't know about
> these tasks, so it doesn't trigger interrupts if there is still some
> work to be done, it's our driver's responsibility to ensure NAPI will be
> rescheduled if needed.
>
> Create a new function to handle these tasks and move the corresponding
> code from mlx5e_napi_poll to the new function to improve modularity and
> prepare for the changes in the following patch.
>
> Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
> Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
> Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
