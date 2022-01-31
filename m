From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 31 Jan 2022 11:13:20 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: kbuild: Don't default
 net vendor configs to y
In-Reply-To: <e9e124b0-4ea0-e84c-cd8e-1c6ad4df9d74@pensando.io>
References: <20220131172450.4905-1-saeed@kernel.org>
 <e9e124b0-4ea0-e84c-cd8e-1c6ad4df9d74@pensando.io>
Message-ID: <20220131191320.GA24296@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jan 31, 2022 at 10:04:40AM -0800, Shannon Nelson wrote:
> Is there a particular reason to change this?
> Broken compiles?? Bad drivers?? Over-sized output?

Having default Y is a PITA to people working on an embedded design
that has just one working MAC.  It means having to scroll through tons
of empty stuff when doing `make menuconfig`

Thanks,
Richard
