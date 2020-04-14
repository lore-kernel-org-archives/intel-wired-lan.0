From: Waiman Long <longman@redhat.com>
Date: Tue, 14 Apr 2020 15:37:51 -0400
Subject: [Intel-wired-lan] [PATCH v2 2/2] crypto: Remove unnecessary
 memzero_explicit()
In-Reply-To: <20200414191601.GZ25468@kitsune.suse.cz>
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413222846.24240-1-longman@redhat.com>
 <eca85e0b-0af3-c43a-31e4-bd5c3f519798@c-s.fr>
 <e194a51f-a5e5-a557-c008-b08cac558572@redhat.com>
 <20200414191601.GZ25468@kitsune.suse.cz>
Message-ID: <578fe9b6-1ccd-2698-60aa-96c3f2dd2c31@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/14/20 3:16 PM, Michal Such?nek wrote:
> On Tue, Apr 14, 2020 at 12:24:36PM -0400, Waiman Long wrote:
>> On 4/14/20 2:08 AM, Christophe Leroy wrote:
>>>
>>> Le 14/04/2020 ? 00:28, Waiman Long a ?crit?:
>>>> Since kfree_sensitive() will do an implicit memzero_explicit(), there
>>>> is no need to call memzero_explicit() before it. Eliminate those
>>>> memzero_explicit() and simplify the call sites. For better correctness,
>>>> the setting of keylen is also moved down after the key pointer check.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>> ? .../allwinner/sun8i-ce/sun8i-ce-cipher.c????? | 19 +++++-------------
>>>> ? .../allwinner/sun8i-ss/sun8i-ss-cipher.c????? | 20 +++++--------------
>>>> ? drivers/crypto/amlogic/amlogic-gxl-cipher.c?? | 12 +++--------
>>>> ? drivers/crypto/inside-secure/safexcel_hash.c? |? 3 +--
>>>> ? 4 files changed, 14 insertions(+), 40 deletions(-)
>>>>
>>>> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
>>>> b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
>>>> index aa4e8fdc2b32..8358fac98719 100644
>>>> --- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
>>>> +++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
>>>> @@ -366,10 +366,7 @@ void sun8i_ce_cipher_exit(struct crypto_tfm *tfm)
>>>> ? {
>>>> ????? struct sun8i_cipher_tfm_ctx *op = crypto_tfm_ctx(tfm);
>>>> ? -??? if (op->key) {
>>>> -??????? memzero_explicit(op->key, op->keylen);
>>>> -??????? kfree(op->key);
>>>> -??? }
>>>> +??? kfree_sensitive(op->key);
>>>> ????? crypto_free_sync_skcipher(op->fallback_tfm);
>>>> ????? pm_runtime_put_sync_suspend(op->ce->dev);
>>>> ? }
>>>> @@ -391,14 +388,11 @@ int sun8i_ce_aes_setkey(struct crypto_skcipher
>>>> *tfm, const u8 *key,
>>>> ????????? dev_dbg(ce->dev, "ERROR: Invalid keylen %u\n", keylen);
>>>> ????????? return -EINVAL;
>>>> ????? }
>>>> -??? if (op->key) {
>>>> -??????? memzero_explicit(op->key, op->keylen);
>>>> -??????? kfree(op->key);
>>>> -??? }
>>>> -??? op->keylen = keylen;
>>>> +??? kfree_sensitive(op->key);
>>>> ????? op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
>>>> ????? if (!op->key)
>>>> ????????? return -ENOMEM;
>>>> +??? op->keylen = keylen;
>>> Does it matter at all to ensure op->keylen is not set when of->key is
>>> NULL ? I'm not sure.
>>>
>>> But if it does, then op->keylen should be set to 0 when freeing op->key. 
>> My thinking is that if memory allocation fails, we just don't touch
>> anything and return an error code. I will not explicitly set keylen to 0
>> in this case unless it is specified in the API documentation.
> You already freed the key by now so not touching anything is not
> possible. The key is set to NULL on allocation failure so setting keylen
> to 0 should be redundant. However, setting keylen to 0 is consisent with
> not having a key, and it avoids the possibility of leaking the length
> later should that ever cause any problem.

OK, I can change it to clear the key length when the allocation failed
which isn't likely.

Cheers,
Longman


