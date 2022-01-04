From: Saeed Mahameed <saeed@kernel.org>
Date: Mon, 3 Jan 2022 23:24:11 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: fixup build after bpf
 header changes
In-Reply-To: <20220104034827.1564167-1-kuba@kernel.org>
References: <20220104034827.1564167-1-kuba@kernel.org>
Message-ID: <20220104072411.esukmdx7sy3milmx@sx1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jan 03, 2022 at 07:48:27PM -0800, Jakub Kicinski wrote:
>Recent bpf-next merge brought in header changes which uncovered
>includes missing in net-next which were not present in bpf-next.
>Build problems happen only on less-popular arches like hppa,
>sparc, alpha etc.
>
>I could repro the build problem with ice but not the mlx5 problem
>Abdul was reporting. mlx5 does look like it should include filter.h,
>anyway.
>

I got an internal report on the same thing also, but I couldn't repro
myself neither, I will ask them to test your patch.

