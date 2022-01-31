From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 31 Jan 2022 11:17:06 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: kbuild: Don't default
 net vendor configs to y
In-Reply-To: <30ed8220-e24d-4b40-c7a6-4b09c84f9a1f@gmail.com>
References: <20220131172450.4905-1-saeed@kernel.org>
 <20220131095905.08722670@hermes.local>
 <CAMuHMdU17cBzivFm9q-VwF9EG5MX75Qct=is=F2h+Kc+VddZ4g@mail.gmail.com>
 <20220131183540.6ekn3z7tudy5ocdl@sx1>
 <30ed8220-e24d-4b40-c7a6-4b09c84f9a1f@gmail.com>
Message-ID: <20220131191706.GB24296@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jan 31, 2022 at 10:40:38AM -0800, Florian Fainelli wrote:

> Maybe the rule should go like this: any new driver vendor defaults to n, and
> existing ones remain set to y, until we deprecate doing that and switching
> them all off to n by 5.18?

+1

Actually, I wouldn't mind breaking old configs.  Why?  Because never
once have MY configs ever survived a kernel upgrade.  Manual fix ups
are always needed.

Nobody cares about my configs, so why should I care about theirs?

Thanks,
Richard
