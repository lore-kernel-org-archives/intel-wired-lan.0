From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 1 Feb 2022 07:46:24 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: kbuild: Don't default
 net vendor configs to y
In-Reply-To: <Yfj2GTH3tHraprl0@unreal>
References: <20220131172450.4905-1-saeed@kernel.org>
 <20220131095905.08722670@hermes.local>
 <CAMuHMdU17cBzivFm9q-VwF9EG5MX75Qct=is=F2h+Kc+VddZ4g@mail.gmail.com>
 <20220131183540.6ekn3z7tudy5ocdl@sx1>
 <30ed8220-e24d-4b40-c7a6-4b09c84f9a1f@gmail.com>
 <09c97169-5f9a-fc8f-dea5-5423e7bfef34@twofifty.com>
 <Yfj2GTH3tHraprl0@unreal>
Message-ID: <20220201154624.GA4432@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Feb 01, 2022 at 10:58:01AM +0200, Leon Romanovsky wrote:
> No, kernel configs never were declared as ABI as "regular" users are not
> supposed to touch it. They use something provided by the distro.

+1
